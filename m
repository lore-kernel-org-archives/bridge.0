From: Alessandro Fiorino <a.fiorino@chibacity.it>
Date: Wed, 17 Mar 2004 09:29:46 +0100
References: <20040316082837.1797.qmail@daitarn.register.it>
	<20040316110702.589a76e8@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040316110702.589a76e8@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403170929.46220.a.fiorino@chibacity.it>
Subject: [Bridge] Re: Strange DHCP behaviour with bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

On Tuesday 16 March 2004 20:07, you wrote:
>
> So the packet makes it into the tap0 device, but the bridge doesn't know
> where to send the output.  Are you running spanning tree protocol or not?

No, btrcl showstp br0 says it's disabled

> Look at the contents of the forwarding table (brctl showmacs br0)
> Spanning tree does take a while to settle on startup so it could be that
> you need to wait about a minute till the bridge starts running.
>
> Or may the tap device doesn't have a real hardware mac
> address is confusing it.

brctl showmacs br0 shows the mac address of the local virtual tap interface as 
local, and shows the mac address of the remote virtual interface as remote 
(which I think it's correct)



