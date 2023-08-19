Return-Path: <astrajoan@yahoo.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82969405F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE8A400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1692485452; bh=1al6UIUGjAWijEREY0tN7kOCM87Jx8xq7dRizWUCdNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To;
 b=Dz3C3K7oZo6f+Bf+p/vqMbnB5kW9b7m9e1xfQ80R5vECGiMq0f5OIGbsTf2j9sFx7i6ix3Bu/RzRoYTsZ1274KzmxCnOQ/Laj8Nai+YvlG8sVtX6uUWq0FN3QVMzmyCEEeBurXoDfBuvEVbmTOFwVp9HuE3gjl5cCBkuJGwdYhSboNqC3HdQNDwPRte/gUBY2tlo6D9ZyxHftINAW/QYXHk5NLI6g2qJ1grXvv/jlj4ovbBxQOmLMGl2/lV2kGpUTd4ng15AzMeBllFJviFNdiIyc1fqJpuzO1KJWeROxUsN9W/cf71BchN3wEJFHPWjkA1F73TGza7GyZcLTVbIzw==
Date: Sat, 19 Aug 2023 15:50:48 -0700
From: Ziqi Zhao <astrajoan@yahoo.com>
Message-ID: <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
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

On Sat, Aug 19, 2023 at 12:25:15PM +0300, Nikolay Aleksandrov wrote:
Hi Nik,

Thank you so much for reviewing the patch and getting back to me!

> IIRC there was no bug, it was a false-positive. The reference is held a bit
> longer but then released, so the device is deleted later.

> If you reproduced it, is the device later removed or is it really stuck?

I ran the reproducer again without the patch and it seems you are
correct. It was trying to create a very short-lived bridge, then delete
it immediately in the next call. The device in question "wpan4" never
showed up when I polled with `ip link` in the VM, so I'd say it did not
get stuck.

> How would it leak a reference, could you elaborate?
> The reference is always taken and always released after the call.

This was where I got a bit confused too. The system had a timeout of
140 seconds for the unregister_netdevice check. If the bridge in
question was created and deleted repeatedly, the warning would indeed
not be an actual reference leak. But how could its reference show up
after 140 seconds if the bridge's creation and deletion were all within
a couple of milliseconds?

So I let the system run for a bit longer with the reproducer, and after
~200 seconds, the kernel crashed and complained that some tasks had
been waiting for too long (more than 143 seconds) trying to get hold of
the br_ioctl_mutex. This was also quite strange to me, since on the
surface it definitely looked like a deadlock, but the strict locking
order as I described previously should prevent any deadlocks from
happening.

Anyways, I decided to test switching up the lock order, since both the
refcnt warning and the task stall seemed closely related to the above
mentioned locks. When I ran the reproducer again after the patch, both
the warning and the stall issue went away. So I guess the patch is
still relevant in preventing bugs in some extreme cases -- although the
scenario created by the reproducer would probably never happen in real
usages?

Please let me know whether you have any thoughts on how the above
issues were triggered, and what other information I could gather to
further demystify this bug. Thank you again for your help!

Best regards,
Ziqi
