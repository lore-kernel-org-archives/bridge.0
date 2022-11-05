Return-Path: <SRS0=G+DL=3F=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC081408CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24418408BD
Date: Sat, 5 Nov 2022 17:47:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221105174756.38062fce@rorschach.local.home>
In-Reply-To: <CAHk-=wjkkomrdcrAxxFijs-Lih6vHze+A2TgM+v7-Z7ZkXT+WA@mail.gmail.com>
References: <20221105060024.598488967@goodmis.org>
 <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home>
 <Y2bPlllkHo5DUmLY@zx2c4.com>
 <CAHk-=wjkkomrdcrAxxFijs-Lih6vHze+A2TgM+v7-Z7ZkXT+WA@mail.gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-staging@lists.linux.dev, linux-doc@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, rcu@vger.kernel.org, cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-edac@vger.kernel.org, linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linaro-mm-sig@lists.linaro.org

On Sat, 5 Nov 2022 14:13:14 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> (Comparing output is also fun because the ordering of the patches is
> random, so consecutive runs with the same rule will give different
> patches. I assume that it's just because it's done in parallel, but it
> doesn't help the "try to see what changes when you change the script"
> ;)

What I do to compare is:

 patch -p1 < cocci1.patch
 git commit -a
 git show | patch -p1 -R
 patch -p1 < cocci2.patch
 git diff

Then I see how things changed. This is how I was able to show you the
tweaks I made.

-- Steve
