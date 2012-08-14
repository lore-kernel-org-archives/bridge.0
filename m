Return-Path: <xiyou.wangcong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=NhwzrMdUWdiYz7YPRB0DjILsH+mwbQfWuXT1XgEh/BU=;
	b=NQWcKVPZ1/XlkW2kOx3HfRFBTl7/kGcLAJdEB2xA50+48A8yM/qW0o/p6N+JLtJTkM
	+qoRh9x2Ajg1CukPutujG0gwJboBIPeDTXAlgRXiChE5qESju5Cb+rZJvdi4+7imW5rg
	KsTJCW/31gGx9vqpFuZP+LQS6jOFwQFkdtZjHEYuO11F+014tAFFaMYCO7jOlM2EneAc
	SO8xi3e4AL8I75+eNkFDoPF+s26Nt4JX0GdFKowyuaRzYuhyxxKcd74XIn4PgmqN+stG
	qGagKvape48f2K0ksaD1JbWR6d9HrGPVoGzMvZskpSbAByeDE83W8sl4usNgqPL3AeT0
	QWrA==
Message-ID: <502A1429.9060005@gmail.com>
Date: Tue, 14 Aug 2012 17:02:33 +0800
From: Cong Wang <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-2-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344871635-1052-2-git-send-email-jiri@resnulli.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net-next 01/16] net: introduce upper device
	lists
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, linux-driver@qlogic.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

On 08/13/2012 11:27 PM, Jiri Pirko wrote:
> This lists are supposed to serve for storing pointers to all upper devices.
> Eventually it will replace dev->master pointer which is used for
> bonding, bridge, team but it cannot be used for vlan, macvlan where
> there might be multiple "masters" present.
>
> New upper device list resolves this limitation. Also, the information
> stored in lists is used for preventing looping setups like
> "bond->somethingelse->samebond"

Hi, Jiri,

I have some difficulty to understand this patch description, so take 
bridged bonding as an example, IIUC, both the bridge dev and bonding dev 
will be in the upper dev list of eth0 and eth1? And br0 will be in the 
upper dev list of bond0 too?

I think it would be nice to describe the hierarchy after your patches.

Thanks!

