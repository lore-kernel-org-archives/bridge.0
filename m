Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=+8uym5YTxmXDxvr9aoMRb008j/lgiba16WO9Tbk5kOk=;
	b=MEjPdGlBUxAKmXLDT2rtov/06U5SEHTqC6bhDHLPrI/Rc/m2fWWjvxXoQLCh+ehZFH
	OAKszfC8svdAeBfxBIhCT7je/2sh9ttshRCz27CKREAa215Go5txUlvSyErtU/5QKoqG
	fuQL3jbfNRzwlfoadEImaFxs3roIfHwObajxU=
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
	<20190409193911.2d68a64d@shemminger-XPS-13-9360>
	<87y34ijgil.fsf@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b8c233dd-2ade-2305-47c6-731396a6f591@cumulusnetworks.com>
Date: Wed, 10 Apr 2019 14:05:19 +0300
MIME-Version: 1.0
In-Reply-To: <87y34ijgil.fsf@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net:bridge:always disable auto-tuning when the
 user specified MTU
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "songliubraving@fb.com" <songliubraving@fb.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "ast@kernel.org" <ast@kernel.org>, "ecree@solarflare.com" <ecree@solarflare.com>, "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, Li Rongqing <lirongqing@baidu.com>, Huang Rui <huangruippp@gmail.com>, "yhs@fb.com" <yhs@fb.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "hawk@kernel.org" <hawk@kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kafai@fb.com" <kafai@fb.com>

On 10/04/2019 13:34, Petr Machata wrote:
> 
> Stephen Hemminger <stephen@networkplumber.org> writes:
> 
>> On Wed, 10 Apr 2019 02:32:08 +0000
>> Huang Rui <huangruippp@gmail.com> wrote:
>>
>>> For example.
>>> My purpose is to create a bridge br0 and join eth0 into br0.
>>> if we use this following way, the auto-tuning flag will not be disabled.
>>>
>>> If eth0's mtu is 1200
>>> step 1.brctl addbr br0
>>> step 2.brctl addif br0 eth0
>>> step 3.ifconfig br0 mtu 1200
>>> step 4.ifconfig eth0 mtu 1500
>>>
>>> Result:
>>> br0's MTU: 1500, eth0's MTU: 1500
>>>
>>> Expected:
>>> br0's MTU: 1200, eth0's MTU: 1500
>>>
>>> I have specified br0's MTU,  but auto-min policy works. So the MTU is
>>> not the result what we expected.
>>> As expected, if i have specified bridge's MTU, it will set the flag:
>>> BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
>>> policy will not work.But in this case, because the dev_set_mtu return
>>> early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
>>> auto-min/max policy will still work.
>>>
>>> Signed-off-by: Huang Rui <huangruiPPP@gmail.com>
>>
>> A bridge like this going to drop frames.
>> A frame received with MTU of 1200 will get dropped.
> 
> That's true even if above you set br0's MTU to 1201, but then the
> auto-tuning is disabled as expected. The problem is that setting MTU to
> 1200 is perceived as a non-change, whereas it should instead be
> perceived as a signal that the user takes over the MTU management.
> 
>> The proper way to do this is to change MTU of both interfaces to match.

The only problem is a lot of the network configuration software these days
sets the MTU by default and that would lead to disabling auto-tune by default.
And since you haven't received a notification it means nothing has changed,
but in this case state has changed for the bridge quietly. It could break setups
which rely on the auto-tune and it would do it quietly which won't be easy to debug.

Also as I said in my previously, I really don't like adding bridge-specific
code in there. Another more ambitious approach would be to maybe always pass the
value to the drivers and let them deal with it, that would require going through all
ndo_change_mtu users and also would still not solve the problem of not sending
a notification when there has been a state change (the bridge no longer auto-tunes).
Thus the bridge will probably have to emit *some* notification by itself.

Perhaps this should've been a bridge option from the start instead of automatic
decision but it's late for that now.

Thanks,
 Nik
