Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kpCEf/Qq7tuBHkUCvzw9RDQhyuv+fkTrLJtMvQIPB04=;
	b=qk4XpOUrgdAyWaYDdG7h6tprWKEK6itk0//ZrqrqyoY7gjC+0AgDmpzNeW9N+4twsb
	PNeU7GmxnWKBUWcpK5Mu+MjTzeTgI5HNruxyPimpPtni+YYo2Mq946tsXYAwXnA4VM6c
	e6zR94qu1RzUUSsce4TQFBR9pXfg8IKhMptrM9q+VckxVJUdM08X79lwWhG4IesgnSVD
	y6/P0JoZSfEshzh8XDsNtF9tx8p/I+yW9F69pylWW6XVhov23qd57f092E3ucoyy+OZK
	VCxOdzbydInBLhlKaLwOXFsXKA2xWTm6IDHhrT0g2UFPICef5AweOOV66Vc9+Upgofiy
	gKfQ==
Date: Tue, 9 Apr 2019 19:39:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190409193911.2d68a64d@shemminger-XPS-13-9360>
In-Reply-To: <20190410023208.25435-1-huangruiPPP@gmail.com>
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Huang Rui <huangruippp@gmail.com>
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, ast@kernel.org, ecree@solarflare.com, xdp-newbies@vger.kernel.org, daniel@iogearbox.net, bridge@lists.linux-foundation.org, john.fastabend@gmail.com, lirongqing@baidu.com, yhs@fb.com, alexander.h.duyck@intel.com, hawk@kernel.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, idosch@mellanox.com, jiri@mellanox.com, amritha.nambiar@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bpf@vger.kernel.org, kafai@fb.com

On Wed, 10 Apr 2019 02:32:08 +0000
Huang Rui <huangruippp@gmail.com> wrote:

> For example.
> My purpose is to create a bridge br0 and join eth0 into br0.
> if we use this following way, the auto-tuning flag will not be disabled.
> 
> If eth0's mtu is 1200
> step 1.brctl addbr br0
> step 2.brctl addif br0 eth0
> step 3.ifconfig br0 mtu 1200
> step 4.ifconfig eth0 mtu 1500
> 
> Result:
> br0's MTU: 1500, eth0's MTU: 1500
> 
> Expected:
> br0's MTU: 1200, eth0's MTU: 1500
> 
> I have specified br0's MTU,  but auto-min policy works. So the MTU is
> not the result what we expected.
> As expected, if i have specified bridge's MTU, it will set the flag:
> BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
> policy will not work.But in this case, because the dev_set_mtu return
> early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
> auto-min/max policy will still work.
> 
> Signed-off-by: Huang Rui <huangruiPPP@gmail.com>

A bridge like this going to drop frames.
A frame received with MTU of 1200 will get dropped.
The proper way to do this is to change MTU of both interfaces to match.

