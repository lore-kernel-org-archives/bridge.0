Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vTKVuZ2QR6rXGjk6/X2/a/WeOHrosvic3Ql+ZuIkvTY=;
	b=yfYeZaXqsanXdsOtjBKrOznNK8lmMtpn6g3arMHQI3kwDh+cRyuQoecmFBcFu+zNNW
	p6mc8OAByuVO+3Knd9ho02ePyRtPMl5ugTRvdGjKDbnm4k7gToBXLaW5DS6kNVTCVgr9
	oMN3LraCAEFjqkgTHa+hveEeV/OEYWNsaFVcrf+GruHkUt8JqyfHJn1ZEXzdQsciPle7
	/nigCujzEW1yIcRce9FC01n4Xd+WW2Qh6z9hEq5Y2Fy+a1hWs12kIEUXoayz7c9if6gh
	asugUDDUVSBrODJ3rJyNU7c/lVdr68QzFOTmzXkRRscXA4AhslAJOIyfjo4ijlwZ3JQj
	sH1A==
Date: Thu, 11 May 2017 09:01:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170511090132.79fdbf12@xeon-e3>
In-Reply-To: <20170511134629.139528-2-fredrik.markstrom@gmail.com>
References: <20170511134629.139528-1-fredrik.markstrom@gmail.com>
	<20170511134629.139528-2-fredrik.markstrom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v2 1/2] net: Added mtu parameter to
 dev_forward_skb calls
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fredrik Markstrom <fredrik.markstrom@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, 11 May 2017 15:46:27 +0200
Fredrik Markstrom <fredrik.markstrom@gmail.com> wrote:

> From: Fredrik Markstr=C3=B6m <fredrik.markstrom@gmail.com>
>=20
> is_skb_forwardable() currently checks if the packet size is <=3D mtu of
> the receiving interface. This is not consistent with most of the hardware
> ethernet drivers that happily receives packets larger then MTU.

Wrong.

Hardware interfaces are free to drop any packet greater than MTU (actually =
MTU + VLAN).
The actual limit is a function of the hardware. Some hardware can only limi=
t by
power of 2; some can only limit frames larger than 1500; some have no limit=
ing at all.
Any application that should:
  * not expect packets larger than MTU to be received
  * not send packets larger than MTU
  * check actual receive size. IP protocols will do truncation of padded pa=
ckets
