Message-ID: <4120114F.60906@shorewall.net>
Date: Sun, 15 Aug 2004 18:43:43 -0700
From: Tom Eastep <teastep@shorewall.net>
MIME-Version: 1.0
References: <411EAF08.3000401@shorewall.net> <411F5D5E.4000001@trash.net>
	<411F7B87.7060303@shorewall.net> <41200E80.2000005@trash.net>
In-Reply-To: <41200E80.2000005@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Patrick McHardy <kaber@trash.net>
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick McHardy wrote:
| Tom Eastep wrote:
|
|> | Have you applied the ipsec+netfilter patches ? Without them, packets
|> are
|> | only seen encrypted in the OUTPUT chain.
|> |
|> Yes -- the ipsec+netfilter patches are applied. Here is the same test
|> with the bridge removed and the local ip address transfered to one of
|> the network cards:
|
|
| The problem is ipv4_sabotage_out in the briding code. It prevents the
| packet from hitting the LOCAL_OUT hook while it is still unencrypted.
| When it hits the bridging code and its LOCAL_OUT hook it's too late.
| Not sure how to handle it yet.
|

Thanks for the update.

- -Tom
- --
Tom Eastep    \ Nothing is foolproof to a sufficiently talented fool
Shoreline,     \ http://shorewall.net
Washington USA  \ teastep@shorewall.net

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBIBFOO/MAbZfjDLIRAvS4AJ9eGQhcxVi09h8gmLZ/CpauSYlw1wCePgBQ
trHWmX/wZV/DyIjSz05IGyQ=
=mL/B
-----END PGP SIGNATURE-----
