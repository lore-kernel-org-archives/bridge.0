Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OuqcVR8StOyPYLKCGcj5+GGgadpxwlYD1eesryFNHY4=;
	b=Nzq/78TA/J1vHIqZLel7FoCJt7wrkTj42bvLHbjat55QryDdW9B/CpNTgPluRgCHBc
	SDdtg/Z18PT6dWuh+FTsTmeCrVIS1nM5uGiJmTta5V6E0hp3sEWqrXtevYv2JoRyWkfx
	rRFMK3kScqN266j7MGV2oXs6QSYLJAQhg0qqw=
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<2473404.DTJdS9eVm5@blindfold> <20181001190433.GA29874@splinter>
	<16029249.TkoLblyBmC@blindfold>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <09307ccf-02d6-ce63-7030-fcc560e93f23@cumulusnetworks.com>
Date: Tue, 2 Oct 2018 17:59:31 +0300
MIME-Version: 1.0
In-Reply-To: <16029249.TkoLblyBmC@blindfold>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1] bridge: remove BR_GROUPFWD_RESTRICTED for
 arbitrary forwarding of reserved addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, Ido Schimmel <idosch@idosch.org>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

On 01/10/2018 22:10, Richard Weinberger wrote:
> Am Montag, 1. Oktober 2018, 21:04:33 CEST schrieb Ido Schimmel:
>> On Mon, Oct 01, 2018 at 08:54:08PM +0200, Richard Weinberger wrote:
>>> So the only option is having a bridge and transport STP via tc-mirred
>>> or patching the bridge code (what we do right now).
>>
>> And I vote for the first option. I understand it involves more typing,
> 
> hehe, it is not about typing. The setup is done by a script.
> And we both know that getting a patch upstream is much more work than
> typing a few lines of hacky bash scripts.
> Since I want a decent solution and feedback I'm bringing this up here.
> 
> I could also just go with my in-house patch and don't tell anyone...
> 
>> but I see no reason to push more complexity into the kernel - and break
>> standards - when you can relatively easily accomplish the same thing in
>> other ways.
> 
> If having a bridge plus u32+mirred for STP bypass is the preferred solution,
> I'm fine with it.
> So far we use the kernel patch and didn't test the mirred-bypass a lot.
> My fear was that mirred rules from eth0 to eth1 and back might cause a
> loop or confuse the bridge...
> 
>> Adding Nik and Roopa who now maintain the bridge code and should
>> eventually decide about this.
> 
> Thanks,
> //richard 
> 
> 
> 
> 

Richard please check commit:
commit 5af48b59f35c
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Wed Sep 27 16:12:44 2017 +0300

    net: bridge: add per-port group_fwd_mask with less restrictions
    
    We need to be able to transparently forward most link-local frames via
    tunnels (e.g. vxlan, qinq). Currently the bridge's group_fwd_mask has a
    mask which restricts the forwarding of STP and LACP, but we need to be able
    to forward these over tunnels and control that forwarding on a per-port
    basis thus add a new per-port group_fwd_mask option which only disallows
    mac pause frames to be forwarded (they're always dropped anyway).
    The patch does not change the current default situation - all of the others
    are still restricted unless configured for forwarding.
    We have successfully tested this patch with LACP and STP forwarding over
    VxLAN and qinq tunnels.
    
    Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


Will this work for you ?
It's in the bridge since v4.15.

Thanks,
 Nik

