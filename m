Message-ID: <416DC6EF.9050001@shorewall.net>
From: Tom Eastep <teastep@shorewall.net>
MIME-Version: 1.0
References: <411EAF08.3000401@shorewall.net> <411F7B87.7060303@shorewall.net>
	<41200E80.2000005@trash.net>
	<200408192010.28417.bdschuym@pandora.be>
In-Reply-To: <200408192010.28417.bdschuym@pandora.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Policy match with a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Thu, 14 Oct 2004 00:23:16 -0000
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bart De Schuymer wrote:
> On Monday 16 August 2004 03:31, Patrick McHardy wrote:
>
>>The problem is ipv4_sabotage_out in the briding code. It prevents the
>>packet from hitting the LOCAL_OUT hook while it is still unencrypted.
>>When it hits the bridging code and its LOCAL_OUT hook it's too late.
>>Not sure how to handle it yet.
>
>
> I'll have a look at that after I'm finished with the IPv6 bridge
firewalling
> stuff.
>

Any progress on this?

Thanks,
- -Tom
- --
Tom Eastep    \ Nothing is foolproof to a sufficiently talented fool
Shoreline,     \ http://shorewall.net
Washington USA  \ teastep@shorewall.net
PGP Public Key   \ https://lists.shorewall.net/teastep.pgp.key
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBbcbvO/MAbZfjDLIRAmBsAJsFlFdf6+c5tzT8Z5OGG/nnxoL//wCghS8L
hX2rkQdtF2v7YIwRyfRDLIY=
=6sB9
-----END PGP SIGNATURE-----
