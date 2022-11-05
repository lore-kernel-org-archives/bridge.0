Return-Path: <SRS0=HBtZ=3F=zx2c4.com=Jason@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AC6981BCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62A2681BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1667682204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqdLYS8BDcnZ1CTVSLTL2V9mpBrsInljjeWX569KabI=;
 b=Ek158U/IwAdzp/7JgxH8/niYIDD2c7iDpM/q00frrsf+kptgL3uCiSQ7Xlb7SIQ9YvTtg5
 hlBVvQrg9GahoQxIsHXxgh/CGzM4sTACdo/WX2PYJwuZbLx0SZ+njeVN3snq9LgpG5MQMr
 EBxmnADIwq+lyFhZU+rPI7l5k3bHDuo=
Date: Sat, 5 Nov 2022 22:03:18 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <Y2bPlllkHo5DUmLY@zx2c4.com>
References: <20221105060024.598488967@goodmis.org>
 <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221105123642.596371c7@rorschach.local.home>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, rcu@vger.kernel.org, cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-edac@vger.kernel.org, linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Nov 05, 2022 at 12:36:42PM -0400, Steven Rostedt wrote:
> ----------------------8<------------------------
> @@
> identifier ptr, timer, rfield, slab;
> @@
> (
> -	del_timer(&ptr->timer);
> +	timer_shutdown(&ptr->timer);
> |
> -	del_timer_sync(&ptr->timer);
> +	timer_shutdown_sync(&ptr->timer);
> )
>     ...
> (
> 	kfree_rcu(ptr, rfield);
> |
> 	kmem_cache_free(slab, ptr);
> |
> 	kfree(ptr);
> )
> ---------------------->8------------------------

Something that might help here is changing the `...` into
`... when exists` or into `... when != ptr` or similar.
See this section of the manual:
https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar004.html

Jason
