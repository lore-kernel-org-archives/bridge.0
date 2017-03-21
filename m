Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=V8w60uDCqV6Ul+syvWShyLOQLdd5ErCupOLZ2qYgX8s=;
	b=wR4VsOBmYnIm215jBQlCZtdfB2SsGw2WvrTEYT9cdFIqKy25JsIS4WKn7vTWh622xt
	5o2af2u4V21P6Gd4+ptUNHxzM9C11We346i65lIAKJ7ECkj/eOc8wTJJv0kJjlQyY/Tr
	niaiZ2ts65zBvAnIv4XBwFvFDL//5Bu4T8eZfcUqmJW35l7F6wkDb1iiQf1tjUI79UmL
	qvtXQVZ7yXL3vNQajCrZZfpXZDyb2TVyy/IgXniyh0+q71Sidr1eQCSmQYx5ZPZM8Sp7
	eQzucUh++gRqBOM+dL4qDm75npr5Z9ZQhq0KkNezWfJJJ4tlQRjdKxSxTek6xPIIPnag
	VJbg==
Date: Tue, 21 Mar 2017 16:32:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170321163245.34159349@xeon-e3>
In-Reply-To: <20170321222845.8373-1-linus.luessing@c0d3.blue>
References: <20170321222845.8373-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v2] bridge: ebtables: fix reception of frames
 DNAT-ed to bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Tue, 21 Mar 2017 23:28:45 +0100
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> However, the IP code drops it in the beginning of ip_input.c/ip_rcv()
> as the dnat target did not update the skb->pkt_type. If after
> dnat'ing the packet is now destined to us then the skb->pkt_type
> needs to be updated from PACKET_OTHERHOST to PACKET_HOST, too.

Why not fix DNAT netfilter module rather than hacking bridge code here.
