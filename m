Return-Path: <torvalds@linuxfoundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CCAA81DAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 613AC81D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oAUSnUna3zS1fBFrtEIiCL0CSikhXV9H9gl4bxAoOlg=;
 b=ZuJIeLB+J2B+Wi1b1yHoLdNdJG615BQeh3CPU6LD93y3msmDVTjWdZW9SDWuwWG0Ca
 YhJ+P7666j6kD5Xt3qGOHQOk6MqT4dr6x8NEoIAvnzfrmsju0oEob+uN+nSjB06pGmVE
 9YOPL0fQ+TfTab0XaBhkdWiy9kYH1H39RsusA=
MIME-Version: 1.0
References: <20221105060024.598488967@goodmis.org>
 <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home> <Y2bPlllkHo5DUmLY@zx2c4.com>
In-Reply-To: <Y2bPlllkHo5DUmLY@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Nov 2022 14:13:14 -0700
Message-ID: <CAHk-=wjkkomrdcrAxxFijs-Lih6vHze+A2TgM+v7-Z7ZkXT+WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org, cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-edac@vger.kernel.org, linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linaro-mm-sig@lists.linaro.org

On Sat, Nov 5, 2022 at 2:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Something that might help here is changing the `...` into
> `... when exists` or into `... when != ptr` or similar.

I actually tried that.

You don't want "when exists", you'd want "when forall", but that seems
to be the default.

And trying "when != ptr->timer" actually does the right thing in that
it gets rid of the case where the timer is modified outside of the
del_timer() case, *but* it also causes odd other changes to the
output.

Look at what it generates for that

   drivers/media/usb/pvrusb2/pvrusb2-hdw.c

file, which finds a lot of triggers with the "when !=  ptr->timer",
but only does one without it.

So I gave up, just because I clearly don't understand the rules.

(Comparing output is also fun because the ordering of the patches is
random, so consecutive runs with the same rule will give different
patches. I assume that it's just because it's done in parallel, but it
doesn't help the "try to see what changes when you change the script"
;)

                 Linus
