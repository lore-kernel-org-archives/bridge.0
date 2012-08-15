Return-Path: <nicolas.2p.debian@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=3UDtQx1OcOn99pUPoJXDuvpx7ly8ZnCOQQcu8UHvsQo=;
	b=Dccs7tXAntpWidLCmBF3KH8lbIAOwC7wpUIslswLEXe5MTC4p+MqEQz9IgDLUQWNdV
	f67SbwAkWx/iijkEltPlLpqgDeXxxLljM/z7y3asQ2csbnZNN2rj7EZHX2oSz3/+DqQA
	6htIa6U+2pbT5gDcEcjIZfy4kq//QqO3s0O3iGlNO+ZgNFQezjLPzRdrfbzPloU1doIT
	TYgRYgKtM8KxnB6l+d25iQgK7YXqRArDBIioO0fKrcfEfqor4sfyvko0M8x54JoRaUMS
	MeuVFMbb/HZByUEIU4ATkjzKlGjbjE9iBaCmu2TXnZ8GW1vfAtdr/a2HgEEN5oakuGia
	NWFw==
Message-ID: <502C07B4.6050104@gmail.com>
Date: Wed, 15 Aug 2012 22:33:56 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-2-git-send-email-jiri@resnulli.us>
	<1344877451.2733.26.camel@bwh-desktop.uk.solarflarecom.com>
	<20120813173110.GA1808@minipsycho.orion>
In-Reply-To: <20120813173110.GA1808@minipsycho.orion>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, linux-driver@qlogic.com, Ben Hutchings <bhutchings@solarflare.com>, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, gregory.v.rose@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Le 13/08/2012 19:31, Jiri Pirko a =E9crit :
> Mon, Aug 13, 2012 at 07:04:11PM CEST, bhutchings@solarflare.com wrote:

>>> +struct netdev_upper {
>>> +	struct net_device *dev;
>>> +	bool unique;
>>
>> This needs a better name.  It doesn't really have anything to do with
>> uniqueness and doesn't ensure exclusivity.  I think that it would be
>> fine to keep the 'master' term.
>
> Hmm. I admit that "unique" I do not like too much as well. But "master"
> I like even less.
>
> This flag should ensure exclusivity. Only one upper device with this
> flag can be present at a time.

Well, can't we simply call it "upper_device"?

And as we only have a single field, this is exclusive by design.

	Nicolas.
