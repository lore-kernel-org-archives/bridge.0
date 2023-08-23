Return-Path: <astrajoan@yahoo.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16737404F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CD87404D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1692783529; bh=+w0Wm6hyHlWivjBgD62leWRc9RGZrULFgUCRifIBJP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To;
 b=KSXvdKHMTxWHxK4vL3v/uVmEYg3AejG9NLZbluoF8tdjYQctcQDOQciFNISLS2LAe6yXGmihisqllrTtLSLaNoPPhQL8Tvgkni16Ol6smpwasXWy2AwOvu1IDmICk5R/DCjmQj7/CKzz8qZa4ret4AP8zXKzRfoKSNgIY7sypWnocimBt4wc2IlthtMqjr3lgGIY4BNCateLfwWoYEBdik0J3qBQ5pzoLWhIwzyBG98s9jNXD50aEK0RP7zWp7aUzrOxYIqLyAiEhIaIR6BUnMxpL/5cllfIZUhnb9T81B+kBHeFu83w+ERS0R3hpjZiLBsol+8niejQQLKBBEWFmw==
Date: Wed, 23 Aug 2023 02:38:46 -0700
From: Ziqi Zhao <astrajoan@yahoo.com>
Message-ID: <20230823093846.7wzrhnqdk2wyqud2@Astras-Ubuntu>
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
 <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
 <c81340d8-25f3-4014-b881-5afe01b56f6b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81340d8-25f3-4014-b881-5afe01b56f6b@blackwall.org>
Subject: Re: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: f.fainelli@gmail.com, ivan.orlov0322@gmail.com, keescook@chromium.org, arnd@arndb.de, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, mudongliangabcd@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, kuba@kernel.org, skhan@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net, hkallweit1@gmail.com

On Tue, Aug 22, 2023 at 01:40:45PM +0300, Nikolay Aleksandrov wrote:

> Thank you for testing, but we really need to understand what is going on and
> why the device isn't getting deleted for so long. Currently I don't have the
> time to debug it properly (I'll be able to next week at the earliest). We
> can't apply the patch based only on tests without understanding the
> underlying issue. I'd look into what
> the reproducer is doing exactly and also check the system state while the
> deadlock has happened. Also you can list the currently held locks (if
> CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See which
> process is holding them, what are their priorities and so on.
> Try to build some theory of how a deadlock might happen and then go
> about proving it. Does the 8021q module have the same problem? It uses
> similar code to set its hook.

Hi Nik,

Thank you so much for the instructions! I was able to obtain a decoded
stacktrace showing the reproducer behavior in my QEMU VM running kernel
6.5-rc4, in case that would give us more context for pinpointing the
problem. Here's a link to the output:

https://pastecat.io/?p=IlKZlflN9j2Z2mspjKe7

Basically, after running the reproducer (line 1854) for about 180
seconnds or so, the unregister_netdevice warning was shown (line 1856),
and then after another 50 seconds, the kernel detected that some tasks
have been stalled for more than 143 seconds (line 1866), so it panicked
on the blocked tasks (line 2116). Before the panic, we did get to see
all the locks held in the system (line 2068), and it did show that many
processes created by the reproducer were contending the br_ioctl_mutex.
I'm now starting to wonder whether this is really a deadlock, or simply
some tasks not being able to grab the lock because so many processes
are trying to acquire it.

Let me know what you think about the situation shown in the above log,
and let's keep in touch for any future debugging. Thank you again for
guiding me through the problem!

Best regards,
Ziqi
