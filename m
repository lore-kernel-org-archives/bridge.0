From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Bridge and PACKET-socket
Date: Mon, 12 Jan 2004 22:47:11 +0100
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<slrnbvr1kp.gtv.lunz@absolut.localnet>
	<lh8ykczxqr.fsf@dodo.bluetail.com>
In-Reply-To: <lh8ykczxqr.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401122247.11045.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Luke Gorrie <luke@bluetail.com>, Jason Lunz <lunz@falooley.org>
Cc: bridge@osdl.org

On Monday 12 January 2004 22:02, Luke Gorrie wrote:
> Still, I find the current semantics of packet sockets on bridged ports
> pretty confusing. It took me a full day to figure out why I wasn't
> receiving the packets I wanted, even though tcpdump did.

Well, that list for protocol-specific functions contains functions to deal 
with the packet, e.g. route it. Obviously we don't want these functions to be 
executed before the bridge code can have a look at it, so that's not very 
confusing.
If you really want to use the protocol-specific list for packets entering on a 
bridge port, you can. Just use the ebtables brouting chain to "broute" the 
packet, see the website. I guess you lose a little performance there, but you 
shouldn't really feel it.

cheers,
Bart

