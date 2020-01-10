Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=date:in-reply-to:references:mime-version:content-transfer-encoding
 :subject:to:cc:from:message-id;
 bh=1Ym1ky3QD6f3IfF+EM/zO4+gog3cH55P6RTJDsna7IQ=;
 b=E38DqpbV3vggOQto0Gi9BjS2Txq4gAHx7whMemoyjXJNP75s1nKgPat2YZRL432Tao
 qYWsDoTkFfl/v8ouvUvcpfEsKsNgoqvLwPPUpzcCUvr1wip+DAocvEVOjgTLKrFRxZHk
 SoGgYf71/qtcoy41LLSYnM/sNCy++UXCF9L6o=
Date: Fri, 10 Jan 2020 22:03:37 +0200
In-Reply-To: <20200110.112736.1849382588448237535.davem@davemloft.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
 <20200110.112736.1849382588448237535.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <3CD4F75F-C462-4CF2-B31A-C2E023D3F065@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
	for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: andrew@lunn.ch, jakub.kicinski@netronome.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com, dsahern@gmail.com, olteanv@gmail.com, horatiu.vultur@microchip.com

On 10 January 2020 21:27:36 EET, David Miller <davem@davemloft=2Enet> wrote=
:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>
>Date: Fri, 10 Jan 2020 16:13:36 +0200
>
>> I agree with Stephen here, IMO you have to take note of how STP has
>progressed
>> and that bringing it in the kernel was a mistake, these days mstpd
>has an active
>> community and much better support which is being extended=2E This looks
>best implemented
>> in user-space in my opinion with minimal kernel changes to support
>it=2E You could simply
>> open a packet socket with a filter and work through that, you don't
>need new netlink
>> sockets=2E I'm not familiar with the protocol so can't really be the
>judge of that, if
>> you present a good argument for needing a new netlink socket for
>these packets - then
>> sure, ok=2E
>
>With a userland implementation, what approach do you suggest for
>DSA/switchdev offload
>of this stuff?

Good question, there was no mention of that initially, or I missed it at l=
east=2E=20
There aren't many details about what/how will be offloaded right now=2E
We need more information about what will be offloaded and how it will fit=
=2E=20



l
