document.addEventListener("DOMContentLoaded", function () {
    const zuptoContainer = document.createElement("div");
    zuptoContainer.className = "fixed bottom-6 right-6 z-50";
    zuptoContainer.innerHTML = `
        <button id="zuptoToggleBtn" onclick="window.toggleZupto()" 
                class="flex items-center gap-2.5 px-4 py-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white font-bold rounded-full shadow-2xl shadow-red-600/40 border border-red-400/30 transition transform hover:scale-105 active:scale-95 text-xs">
            <span class="relative flex h-2.5 w-2.5">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-400"></span>
            </span>
            <i class="fa-solid fa-robot text-sm"></i>
            <span>Ask Zupto AI 🔥</span>
        </button>

        <div id="zuptoChatWindow" class="hidden absolute bottom-14 right-0 w-80 sm:w-96 bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl overflow-hidden flex flex-col text-slate-100">
            <div class="bg-gradient-to-r from-slate-950 via-slate-900 to-red-950/60 p-3.5 border-b border-slate-800 flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                    <div class="w-8 h-8 rounded-full bg-red-600/20 border border-red-500/40 flex items-center justify-center text-red-500 font-bold text-xs">
                        <i class="fa-solid fa-bolt"></i>
                    </div>
                    <div>
                        <h4 class="text-xs font-bold text-white flex items-center gap-1.5">
                            Zupto AI Gym Partner
                            <span class="bg-emerald-500/20 text-emerald-400 text-[9px] font-semibold px-1.5 py-0.2 rounded">Active Bro</span>
                        </h4>
                        <p class="text-[10px] text-slate-400">VT Mart Friendly Fitness Coach</p>
                    </div>
                </div>
                <button onclick="window.toggleZupto()" class="text-slate-400 hover:text-white text-sm p-1">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>

            <div id="zuptoMessages" class="p-4 h-64 overflow-y-auto space-y-3 text-xs">
                <div class="bg-slate-950 border border-slate-800/80 rounded-xl p-3 text-slate-300">
                    <p class="font-semibold text-red-400 mb-1">Enna thala, vanakkam! 💪</p>
                    <p>Naan dhaan unga **Zupto AI partner**. Gym setup pannanuma, workout tips venuma, illa nalla equipment thedureengala? Enkitta edhu venaalum kelunga bro!</p>
                </div>
            </div>

            <div class="px-3 py-2 bg-slate-950/60 border-t border-slate-800/60 flex gap-1.5 overflow-x-auto text-[10px]">
                <button onclick="window.sendQuickPrompt('Home gym setup under 10k sollu bro')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    🏋️ Home Gym &lt; ₹10k
                </button>
                <button onclick="window.sendQuickPrompt('Deadlift and squat-ku nalla barbell sollu')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    💪 Best Barbell
                </button>
                <button onclick="window.sendQuickPrompt('Weight loss and belly fat reduce panna enna gear venum?')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    🔥 Fat Loss Gear
                </button>
            </div>

            <div class="p-2.5 bg-slate-950 border-t border-slate-800 flex gap-2">
                <input type="text" id="zuptoInput" placeholder="Kelu bro, enna venum gym gear pathi..." 
                       onkeydown="if(event.key==='Enter') window.sendZuptoMsg()"
                       class="flex-1 bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                <button onclick="window.sendZuptoMsg()" class="px-3 py-2 bg-red-600 hover:bg-red-700 text-white rounded-xl text-xs transition">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
    `;
    document.body.appendChild(zuptoContainer);

    window.toggleZupto = function () {
        const win = document.getElementById("zuptoChatWindow");
        if (win) win.classList.toggle("hidden");
    };

    window.sendQuickPrompt = function (promptText) {
        const input = document.getElementById("zuptoInput");
        if (input) {
            input.value = promptText;
            window.sendZuptoMsg();
        }
    };

    window.sendZuptoMsg = function () {
        const input = document.getElementById("zuptoInput");
        const txt = input ? input.value.trim() : "";
        if (!txt) return;

        const box = document.getElementById("zuptoMessages");
        const uDiv = document.createElement("div");
        uDiv.className = "bg-red-600/20 border border-red-500/30 rounded-xl p-2.5 text-slate-100 ml-6 text-right";
        uDiv.innerText = txt;
        box.appendChild(uDiv);
        input.value = "";
        box.scrollTop = box.scrollHeight;

        setTimeout(() => {
            let reply = "";
            const lower = txt.toLowerCase();

            if (lower.includes("10k") || lower.includes("home gym") || lower.includes("budget")) {
                reply = "Mass bro! 10k budget-la cast iron kettlebell, hex dumbbells, lock collars set potralam. VT Mart-la insured delivery free thala!";
            } else if (lower.includes("barbell") || lower.includes("deadlift") || lower.includes("squat")) {
                reply = "Heavy deadlift and squats-ku 20kg Olympic Barbell dhaan king! Needle bearing smooth-aa irukkum, slip aagadhu.";
            } else if (lower.includes("fat loss") || lower.includes("belly") || lower.includes("cardio") || lower.includes("weight loss")) {
                reply = "Fat loss-ku Kettlebell swings + Battle Ropes 20 mins HIIT panna calorie burn double aagum machan!";
            } else {
                reply = "Super thala! Commercial 11-gauge steel gear dhaan namma VT Fitness Mart-la irukku. Catalog paathu add pannikonga!";
            }

            const bDiv = document.createElement("div");
            bDiv.className = "bg-slate-950 border border-slate-800/80 rounded-xl p-3 text-slate-300";
            bDiv.innerHTML = "<p class='font-bold text-red-400 mb-1 flex items-center gap-1.5'><i class='fa-solid fa-bolt'></i> Zupto Bhai Solren:</p>" + reply;
            box.appendChild(bDiv);
            box.scrollTop = box.scrollHeight;
        }, 500);
    };
});
