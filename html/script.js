document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('notification-container');
    let notificationConfig = {};
    let showProgressGlobal = true;
    let audioContext;
    const audioCache = new Map();

    function initAudioContext() {
        if (!audioContext) {
            audioContext = new (window.AudioContext || window.webkitAudioContext)();
        }
        return audioContext;
    }

    async function playSound(url, volume = 0.4) {
            const context = initAudioContext();

            if (context.state === 'suspended') {
                await context.resume();
            }
            
            let audioBuffer;
            if (audioCache.has(url)) {
                audioBuffer = audioCache.get(url);
            } else {
                const response = await fetch(url);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                audioBuffer = await context.decodeAudioData(await response.arrayBuffer());

                audioCache.set(url, audioBuffer);
            }

            const source = context.createBufferSource();
            const gainNode = context.createGain();
            
            source.buffer = audioBuffer;
            gainNode.gain.value = volume;
            
            source.connect(gainNode);
            gainNode.connect(context.destination);
            source.start(0);
    }

    function createNotification({ type, title, text, duration, icon, showProgress }) {
        const notif = document.createElement('div');
        notif.className = `notification ${type}`;

        const typeConfig = notificationConfig[type] || {};
        const finalIcon = icon || typeConfig.icon;
        const finalColor = typeConfig.color || '#ffffff';
        const finalDuration = duration || 5000;
        const finalShowProgress = showProgress ?? showProgressGlobal; 

        const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        
        let notificationHTML = '';
        
        if (finalIcon) {
            notificationHTML += `
                <div class="icon-container">
                    <i class="${finalIcon}"></i>
                </div>
            `;
        }
        
        notificationHTML += `
            <div class="content">
                ${title ? `<h3 class="title">${title}</h3>` : ''}
                ${text ? `<p class="description">${text}</p>` : ''}
            </div>
        `;
        
        notificationHTML += `<span class="timestamp">${time}</span>`;
        
        if (finalShowProgress) {
            notificationHTML += '<div class="progress-bar-container"><div class="progress-bar"></div></div>';
        }
        
        notif.innerHTML = notificationHTML;
        
        const iconContainer = notif.querySelector('.icon-container');
        const progressBar = notif.querySelector('.progress-bar');
        
        if (iconContainer) {
            iconContainer.style.color = finalColor;
        }
        
        if (progressBar) {
            progressBar.style.background = finalColor;

            if (finalShowProgress) {
                let startTime = null;
                const animateProgressBar = (currentTime) => {
                    if (!startTime) startTime = currentTime;
                    const elapsed = currentTime - startTime;
                    const progress = Math.min(elapsed / finalDuration, 1);
                    progressBar.style.width = (progress * 100) + '%';

                    if (progress < 1) {
                        requestAnimationFrame(animateProgressBar);
                    }
                };
                requestAnimationFrame(animateProgressBar);
            }
        }
        
        container.appendChild(notif);

        setTimeout(() => {
            notif.classList.add('closing');
            notif.addEventListener('animationend', (e) => {
                if (e.animationName === 'slideOut') {
                    notif.remove();
                }
            }, { once: true });
        }, finalDuration);
    }
    
    window.addEventListener('message', (event) => {
        const { action } = event.data;
        
        if (action === 'showNotification') {
            createNotification(event.data);
        } else if (action === 'setNotificationConfig') {
            notificationConfig = event.data.notifications;
            showProgressGlobal = event.data.showProgressGlobal;
        } else if (action === 'playSound') {
            playSound(event.data.url, event.data.volume);
        }
    });
});
