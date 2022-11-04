Return-Path: <SRS0=+Cc8=3E=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76DDD40184
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B654840018
Date: Fri, 4 Nov 2022 16:38:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221104154355.578ab689@rorschach.local.home>
In-Reply-To: <20221104154209.21b26782@rorschach.local.home>
References: <20221104054053.431922658@goodmis.org>
 <20221104192232.GA2520396@roeck-us.net>
 <20221104154209.21b26782@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC][PATCH v3 00/33] timers: Use timer_shutdown*()
 before freeing timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, rcu@vger.kernel.org, cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-edac@vger.kernel.org, linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 4 Nov 2022 15:42:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> $ git grep '\btimer_shutdown'
> arch/arm/mach-spear/time.c:static inline void timer_shutdown(struct clock_event_device *evt)
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> drivers/clocksource/arm_arch_timer.c:static __always_inline int timer_shutdown(const int access,
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
> drivers/clocksource/timer-fttmr010.c:   int (*timer_shutdown)(struct clock_event_device *evt);



> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:           fttmr010->timer_shutdown = ast2600_timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:           fttmr010->timer_shutdown = fttmr010_timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:   fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:   fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;

I won't touch structure fields though.

-- Steve


> drivers/clocksource/timer-sp804.c:static inline void timer_shutdown(struct clock_event_device *evt)
> drivers/clocksource/timer-sp804.c:      timer_shutdown(evt);
> drivers/clocksource/timer-sp804.c:      timer_shutdown(evt);
