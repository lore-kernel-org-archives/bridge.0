Return-Path: <rdunlap@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oTLsonCa2JJCZquZIr02tCIa6cKQIoCJzf/6u+G0eLM=;
	b=VpMFLl0A1PNebanbYxVShplQ6
	owR9HSB6WQhXM7FtQ1KBgyZTkRk+yHQ86qtMqsWD7hr1P1GIddyL7uHdtmbhh9J/rne41GOgTIuXb
	QNcLmNfEz83irO95WBGPJwNxEL7VeTbBmn8rB2gok7N3zhLJpu93XP3shL9iRYPuvF7r8XEQhdYyT
	UIVMdSeS457+iMuygc27wzDX/39tdKnOExx0nSZcn+NNwbkkzcKUHC5Huh98ImRDvsOxLsyuqkLd9
	YhcgjlmrsTueF3dyb9g/ryQnaf9HSD4mYJu4PpPdV5c+JZX5myz+xgOkjcpg8KV0NVPnHQIdrXq4K
	oqNJkdL/g==;
References: <20190807183606.372ca1a4@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f54391d9-6259-d08b-8b5f-c844093071d8@infradead.org>
Date: Wed, 7 Aug 2019 08:29:44 -0700
MIME-Version: 1.0
In-Reply-To: <20190807183606.372ca1a4@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] linux-next: Tree for Aug 7
 (net/bridge/netfilter/nf_conntrack_bridge.c)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 8/7/19 1:36 AM, Stephen Rothwell wrote:
> Hi all,
>=20
> Changes since 20190806:
>=20

on i386:
when CONFIG_NF_TABLES is not set/enabled:

  CC      net/bridge/netfilter/nf_conntrack_bridge.o
In file included from ../net/bridge/netfilter/nf_conntrack_bridge.c:21:0:
../include/net/netfilter/nf_tables.h: In function =91nft_gencursor_next=92:
../include/net/netfilter/nf_tables.h:1224:14: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return net->nft.gencursor + 1 =3D=3D 1 ? 1 : 0;
              ^~~
              nf
In file included from ../include/linux/export.h:45:0,
                 from ../include/linux/linkage.h:7,
                 from ../include/linux/kernel.h:8,
                 from ../include/linux/skbuff.h:13,
                 from ../include/linux/ip.h:16,
                 from ../net/bridge/netfilter/nf_conntrack_bridge.c:3:
../include/net/netfilter/nf_tables.h: In function =91nft_genmask_cur=92:
../include/net/netfilter/nf_tables.h:1235:29: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return 1 << READ_ONCE(net->nft.gencursor);
                             ^
../include/linux/compiler.h:261:17: note: in definition of macro =91__READ_=
ONCE=92
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
../include/net/netfilter/nf_tables.h:1235:14: note: in expansion of macro =
=91READ_ONCE=92
  return 1 << READ_ONCE(net->nft.gencursor);
              ^~~~~~~~~
../include/net/netfilter/nf_tables.h:1235:29: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return 1 << READ_ONCE(net->nft.gencursor);
                             ^
../include/linux/compiler.h:263:22: note: in definition of macro =91__READ_=
ONCE=92
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
../include/net/netfilter/nf_tables.h:1235:14: note: in expansion of macro =
=91READ_ONCE=92
  return 1 << READ_ONCE(net->nft.gencursor);
              ^~~~~~~~~
../include/net/netfilter/nf_tables.h:1235:29: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return 1 << READ_ONCE(net->nft.gencursor);
                             ^
../include/linux/compiler.h:263:42: note: in definition of macro =91__READ_=
ONCE=92
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
../include/net/netfilter/nf_tables.h:1235:14: note: in expansion of macro =
=91READ_ONCE=92
  return 1 << READ_ONCE(net->nft.gencursor);
              ^~~~~~~~~
../include/net/netfilter/nf_tables.h:1235:29: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return 1 << READ_ONCE(net->nft.gencursor);
                             ^
../include/linux/compiler.h:265:30: note: in definition of macro =91__READ_=
ONCE=92
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
../include/net/netfilter/nf_tables.h:1235:14: note: in expansion of macro =
=91READ_ONCE=92
  return 1 << READ_ONCE(net->nft.gencursor);
              ^~~~~~~~~
../include/net/netfilter/nf_tables.h:1235:29: error: =91const struct net=92=
 has no member named =91nft=92; did you mean =91nf=92?
  return 1 << READ_ONCE(net->nft.gencursor);
                             ^
../include/linux/compiler.h:265:50: note: in definition of macro =91__READ_=
ONCE=92
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
../include/net/netfilter/nf_tables.h:1235:14: note: in expansion of macro =
=91READ_ONCE=92
  return 1 << READ_ONCE(net->nft.gencursor);
              ^~~~~~~~~
make[4]: *** [../scripts/Makefile.build:273: net/bridge/netfilter/nf_conntr=
ack_bridge.o] Error 1



--=20
~Randy
