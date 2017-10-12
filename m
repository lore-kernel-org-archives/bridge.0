Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fZbKwce/FsnwfCQAfekdWdPAEJvFCRQSo/PQLTIeLbo=;
	b=qIHuetGWWZfjs1eFq+bjM5QTLp3XImcy0DCjN6R770O4S4Vp5gG/OJsUFS8lx88x0+
	RbzV+qjY5rYAIkA+TAq5/jvI/nFowgf5mLzkgzI0HaXqV5WhxuGNtGO3uLluWkJa8vJO
	Hw74ylqd4fUoTwKDuXgEVXViISlQuSN2quiyZ5wDWX23Eu7lU4xqUH8UIPCYDr7guTTa
	DpE0iS3W26u0q0Qn/xwLCWbcKPq33Jsqgd6HtbWcb7F8/5LLwQe8ADUfqp5TOVo1UiNS
	WsL8dLhGD/8FdfjQ6rp6rzIOnTjgDGqrA7pQ60HKpK0yAzdDYJV8EoEUnaM74RtlC3YV
	BB8w==
Date: Thu, 12 Oct 2017 07:58:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171012075834.78103e4d@xeon-e3>
In-Reply-To: <CAPfKRs4GmA4568nt4a2kaHkmm3WmMETL1sXcT8xyByCvVGgFkQ@mail.gmail.com>
References: <CAPfKRs4GmA4568nt4a2kaHkmm3WmMETL1sXcT8xyByCvVGgFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problem with syslog in bridge(?) with ethernet
 broadcast packets with QinQ
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?QW5kcsOpcw==?= Pozo =?UTF-8?B?TXXDsW96?= <andres.pozom@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 18 Sep 2017 17:21:11 +0200
Andr=C3=A9s Pozo Mu=C3=B1oz <andres.pozom@gmail.com> wrote:

> Hi all,
>=20
> I'm facing some problem with ethernet multicast traffic and QinQ
> (802.3q in both tags) in -apparently- a bridge in Ubuntu 16.04
> (4.12.0-041200-generic).
>=20
> My set up is the following:
> +-----------+
> |     VM    |
> +-----+-----+
>       |
>       | tag 55
> +---------+------------+
> |        OVS           |
> +-----------+----------+
>                 | veth3.9
> veth3   +  |
>      +--+
>      | veth2
> +-------+----------+
> |       BRIDGE     |
> +-------+----------+
>      |
>      |
> +-------+----------+
> |      ens11f1     |
> +------------------+
>=20
>=20
> I am setting the inner tag with OVS and the outer tag with a vlan type ve=
th.
> The problem I have is that every packet sent from the VM to Ethernet
> broadcast addresses (33:33:xx:xx:xx:xx) generates a "IPv6 header not
> found" entry in syslog.
>=20
> If I generate a 'ens11f1.9' interface and remove the BRIDGE, the log
> entry dissapears.
>=20
> Some questions:
> * Is there any problem with these packets (ethernet multicast with
> QinQ) in bridges?
> * Is there any configuration I should change for the problem to dissapear?
>=20
> Thanks in advance for your help! Any hint about what could be
> generating those logs is appreciated.
>=20
> Regards,
> Andr=C3=A9s Pozo

Where is the log message coming from? Could you change the printk into
a WARN_ON_ONCE and get backtrace? My guess is the firewall code doesn't
understand the additional tag.
