Date: Mon, 30 Oct 2006 15:11:09 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061030151109.54b137f2@freekitty>
In-Reply-To: <20061030230004.18431.qmail@web56910.mail.re3.yahoo.com>
References: <20061030230004.18431.qmail@web56910.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] problem with bridge on soho router,
 when lan interface down, all go down
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Douglas Chen <g5ranger@yahoo.com>
Cc: bridge@lists.osdl.org

On Mon, 30 Oct 2006 15:00:03 -0800 (PST)
Douglas Chen <g5ranger@yahoo.com> wrote:

> >> I was wondering if anyone has experienced this before and appreciate for any solutions!!
> >> Can bridge recognize these ports separately so it doesn't take down everything as a whole?
> >> 
> >
> >Only if they are separate interfaces.
> 
> Can the bridge avoid entering the disabled state then?  At least, I want the interface to respond when there's any traffic coming in from the WAN port.
> 
> Thanks!

The bridge disables by port, each port is a network device. If the network devices
correctly implement carrier, then it can work with some down and some up.
It sounds like either they are all coming on one device, or the device driver is
buggy.

-- 
Stephen Hemminger <shemminger@osdl.org>
