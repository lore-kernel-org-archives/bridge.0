Return-Path: <SRS0=G+DL=3F=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4603060ABE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C42F60AAE
Date: Sat, 5 Nov 2022 14:05:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221105140550.0ccb277c@rorschach.local.home>
In-Reply-To: <20221105140356.6a3da628@rorschach.local.home>
References: <20221105060024.598488967@goodmis.org>
 <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home>
 <20221105140356.6a3da628@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4a 00/38] timers: Use timer_shutdown*() before
 freeing timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, rcu@vger.kernel.org, cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-edac@vger.kernel.org, linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linaro-mm-sig@lists.linaro.org

On Sat, 5 Nov 2022 14:03:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/drivers/isdn/hardware/mISDN/hfcmulti.c
> +++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
> @@ -4544,7 +4544,7 @@ release_port(struct hfc_multi *hc, struct dchannel *dch)
>  	spin_lock_irqsave(&hc->lock, flags);
>  
>  	if (dch->timer.function) {
> -		del_timer(&dch->timer);
> +		timer_shutdown(&dch->timer);
>  		dch->timer.function = NULL;
>  	}
>  

I still hate the above.

-- Steve
