Return-Path: <xiyou.wangcong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=dcuy7pu4un2Gywwi19OD2tuIlxZn2UT7s1XBDGmRceY=;
	b=HGcxNVmHKMBUwHAHGHRLOBo8SP5UOWlb5PWazZV86sAyaUCpzYZ5q5SY0nBankGXMB
	nzqSwZHQMBnG9KxrPIBPjorW6OM2zPWkaGxwKW/8FCIr31E41782sQ4G2u28OsAQBnAz
	vy0moCGeUkGu4I4VuCSGAcR6Ocv0Hc7hI1WQ1+xkaRjPqyW9QcfgA5liErFHubfwJZrC
	MLb5+0t+wER0mFrF/n5WrqHhMtbric0qjN4igBpc6rcb+1akrAXy6jjjy0dar/8XCJQ7
	lqGY6X1zW4AiuJf8shIu0wwy7PevZzrWH634Ge+alatMgjb8S1qKMLOr3lzuZrgj312i
	8hzg==
MIME-Version: 1.0
In-Reply-To: <CAKdL+dQh9ZEWZKHam0Z3iaVpxgZY0mziT3ZWN1OcuS55zUjEXg@mail.gmail.com>
References: <20170509124439.45674-1-fredrik.markstrom@gmail.com>
	<20170509.134839.2008658486655854998.davem@davemloft.net>
	<CAKdL+dQh9ZEWZKHam0Z3iaVpxgZY0mziT3ZWN1OcuS55zUjEXg@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 11 May 2017 20:27:10 -0700
Message-ID: <CAM_iQpVKJp5Dg_x-ymJa-wpLbbgUpn2cQv+--eXRwr2Eh23Vgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 0/2] net: Set maximum receive packet size on
	veth interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Fredrik_Markstr=C3=B6m?= <fredrik.markstrom@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Linux Kernel Network Developers <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>

On Tue, May 9, 2017 at 5:42 PM, Fredrik Markstr=C3=B6m
<fredrik.markstrom@gmail.com> wrote:
>
> Maybe I was unclear, the veth implementation drops all packers larger the=
n the
> configured MTU (on the receiving interface).
> Most ethernet drivers accepts packets up to the ethernet MTU no matter th=
e
> configured MTU. As far as I can tell from the RFC:s that is ok.

This is because IP layer does the fragmentation for you. But some drivers,
for example tg3, drop packet larger than its dev->mtu very early too.

>
> A simpler solution would be to only drop packets larger then ethernet MTU=
 (like
> most network drivers), but I guess that will break existing stuff
> already out there.

I wonder why did we introduce that mtu check for veth when IP layer
could either fragment or reject with ICMP?
