From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] br_add_bridge: Package not installed
Date: Mon, 29 Mar 2004 19:37:29 +0200
References: <9CDD2895B84A1C48B8FD80F9820E9C32048582BC@svlexc07.corp.netapp.com>
In-Reply-To: <9CDD2895B84A1C48B8FD80F9820E9C32048582BC@svlexc07.corp.netapp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403291937.29420.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Feierfeil, Jeff" <firefly@netapp.com>, bridge@osdl.org

On Tuesday 23 March 2004 00:49, Feierfeil, Jeff wrote:
> I am having a tough time simply getting the bridging to work with
> RedHat.  Any help would be greatly appreciated.
>
> [root@redman root]# brctl addbr br0
> br_add_bridge: Package not installed

Looks like you'll need to recompile your kernel and enable the bridging code.

cheers,
Bart

