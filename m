Return-Path: <SRS0=6PJf=4V=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9630760BDB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CABC460B57
Date: Fri, 23 Dec 2022 10:41:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221223104113.0bc8d37f@gandalf.local.home>
In-Reply-To: <20221220134519.3dd1318b@gandalf.local.home>
References: <20221220134519.3dd1318b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] treewide: Convert del_timer*() to
	timer_shutdown*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, drbd-dev@lists.linbit.com, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-atm-general@lists.sourceforge.net, lvs-devel@vger.kernel.org, linux-acpi@vger.kernel.org, SHA-cyfmac-dev-list@infineon.com, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, linux-nfs@vger.kernel.org, linux-block@vger.kernel.org, cgroups@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, brcm80211-dev-list.pdl@broadcom.com, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, 20 Dec 2022 13:45:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> [
>   Linus,
> 
>     I ran the script against your latest master branch:
>     commit b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> 
>     As the timer_shutdown*() code is now in your tree, I figured
>     we can start doing the conversions. At least add the trivial ones
>     now as Thomas suggested that this gets applied at the end of the
>     merge window, to avoid conflicts with linux-next during the
>     development cycle. I can wait to Friday to run it again, and
>     resubmit.
> 
>     What is the best way to handle this?
> ]

Note, I just did a git remote update, checked out the latest, re-ran the
script, and this patch hasn't changed.

-- Steve
