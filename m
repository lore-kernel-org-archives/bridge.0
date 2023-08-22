Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C12B5415D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29F2E415A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692700847; x=1693305647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EtkRY1jmYwwZKGUT6GKi2lYbs/rnolItz7yunjkfTUE=;
 b=vRqJyMPwpBjcl3tf+EYFWQTPiMQZEvD7T6FvKLjABWSOeGSosWuDdjxcvTGKHDmeAt
 Q1oYCxFJBgQBK8pxgazV1n7AlbQ1AP5g3j9REhoJoT2vD0iLM52qYXTZMFj10/vD4MVe
 HY4AQzOMvAjZR/nE8MWjpx72nHJzAxy0Oa2XBOqKRU7XjxmcYfkuHwzUxbv0k/f61RhQ
 r34ZEJnvFi0OwC2hxjTOLj8HiCVdsfe2HHB1xeOzshBeiD7wQRZED/mIGbs6rbHQAMhz
 AHVFSbytRMvaaC45Hr+PGVuLlEPLzd2/7a/9EzHagqYjb3IxPxAMsOn+sIf+pkL9C3V4
 ljBg==
Message-ID: <c81340d8-25f3-4014-b881-5afe01b56f6b@blackwall.org>
Date: Tue, 22 Aug 2023 13:40:45 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
 <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ziqi Zhao <astrajoan@yahoo.com>
Cc: f.fainelli@gmail.com, ivan.orlov0322@gmail.com, keescook@chromium.org, arnd@arndb.de, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, mudongliangabcd@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, kuba@kernel.org, skhan@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net, hkallweit1@gmail.com

On 8/20/23 01:50, Ziqi Zhao wrote:
> On Sat, Aug 19, 2023 at 12:25:15PM +0300, Nikolay Aleksandrov wrote:
> Hi Nik,
> 
> Thank you so much for reviewing the patch and getting back to me!
> 
>> IIRC there was no bug, it was a false-positive. The reference is held a bit
>> longer but then released, so the device is deleted later.
> 
>> If you reproduced it, is the device later removed or is it really stuck?
> 
> I ran the reproducer again without the patch and it seems you are
> correct. It was trying to create a very short-lived bridge, then delete
> it immediately in the next call. The device in question "wpan4" never
> showed up when I polled with `ip link` in the VM, so I'd say it did not
> get stuck.
> 
>> How would it leak a reference, could you elaborate?
>> The reference is always taken and always released after the call.
> 
> This was where I got a bit confused too. The system had a timeout of
> 140 seconds for the unregister_netdevice check. If the bridge in
> question was created and deleted repeatedly, the warning would indeed
> not be an actual reference leak. But how could its reference show up
> after 140 seconds if the bridge's creation and deletion were all within
> a couple of milliseconds?
> 
> So I let the system run for a bit longer with the reproducer, and after
> ~200 seconds, the kernel crashed and complained that some tasks had
> been waiting for too long (more than 143 seconds) trying to get hold of
> the br_ioctl_mutex. This was also quite strange to me, since on the
> surface it definitely looked like a deadlock, but the strict locking
> order as I described previously should prevent any deadlocks from
> happening.
> 
> Anyways, I decided to test switching up the lock order, since both the
> refcnt warning and the task stall seemed closely related to the above
> mentioned locks. When I ran the reproducer again after the patch, both
> the warning and the stall issue went away. So I guess the patch is
> still relevant in preventing bugs in some extreme cases -- although the
> scenario created by the reproducer would probably never happen in real
> usages?
> 

Thank you for testing, but we really need to understand what is going on 
and why the device isn't getting deleted for so long. Currently I don't 
have the time to debug it properly (I'll be able to next week at the 
earliest). We can't apply the patch based only on tests without 
understanding the underlying issue. I'd look into what
the reproducer is doing exactly and also check the system state while 
the deadlock has happened. Also you can list the currently held locks 
(if CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See 
which process is holding them, what are their priorities and so on.
Try to build some theory of how a deadlock might happen and then go
about proving it. Does the 8021q module have the same problem? It uses
similar code to set its hook.

> Please let me know whether you have any thoughts on how the above
> issues were triggered, and what other information I could gather to
> further demystify this bug. Thank you again for your help!
> 
> Best regards,
> Ziqi

