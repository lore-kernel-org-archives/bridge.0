From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] RH 9 problems iptbles + bridge
Date: Thu, 18 Dec 2003 19:35:16 +0100
References: <Pine.LNX.4.44.0312180938040.30335-100000@papput.nsc.liu.se>
In-Reply-To: <Pine.LNX.4.44.0312180938040.30335-100000@papput.nsc.liu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312181935.16344.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hakan Stensby <hst@nsc.liu.se>, bridge@osdl.org

On Thursday 18 December 2003 09:46, Hakan Stensby wrote:
> Hi,
>
> I've been running RH 7.2 with a kernel-2.4.9-13brnf0.0.3 for a very long
> time and works just fine.
>
> A couple of weeks ago I thought I'd install a new fresh installation with
> rh9 and load the bridge module that comes with the rh kernel ( 2.4.20-24.9
> ).
>
> The bridge itself works just fine but the firewalling dont.
> There is no packets passing the FORWARD chain... Have I missed something
> really essential here?
> The same iptable script works just fine on the old box...

You forgot to apply the appropriate bridge-nf patch, see 
ebtables.sourceforge.net.

cheers,
Bart

