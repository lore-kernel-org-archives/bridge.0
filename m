From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] ethernet bridge + iptables
Date: Tue, 27 Apr 2004 19:51:16 +0200
References: <010701c42ba3$288f2570$41317d9e@keziah>
In-Reply-To: <010701c42ba3$288f2570$41317d9e@keziah>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404271951.16326.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Sandford <J.M.Sandford@lboro.ac.uk>, bridge@osdl.org

On Monday 26 April 2004 17:28, Mark Sandford wrote:
> I've since been using 2.4.25 kernel (and then 2.4.26).  Kernel compiles and
> the system doesn't hang when the bridge comes up but I don't seem to be
> able to get it to actually do the bridging.  (Bridging does work with
> initial rh9 install).  The ethernet cards work fine until I bring the
> bridge up.  After that I can't ping from the bridge or forward packets
> through the bridge.
>
> I'm wondering whether I've incorrectly set/missed some options while
> configuring the kernel but I don't know what to try.
>
> Any clues / pointers hugely appreciated.

Please check your firewalling rules.

cheers,
Bart

