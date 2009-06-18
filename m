Date: Wed, 17 Jun 2009 22:58:20 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090617225820.6da02179@nehalam>
In-Reply-To: <2e59e6970906172126x51a7b0c1k8320079bf2d8854b@mail.gmail.com>
References: <4A3824E8.5010905@vodafone.it>
	<2e59e6970906172126x51a7b0c1k8320079bf2d8854b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: Paolo NOTARI <paolo_notari@vodafone.it>, bridge@linux-foundation.org

On Wed, 17 Jun 2009 23:26:40 -0500
"richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote:

> On Tue, Jun 16, 2009 at 6:04 PM, Paolo NOTARI <paolo_notari@vodafone.it>wrote:
> 
> > Hello,
> >
> > I have these two card that I'm trying to use in a bridge :
> >
> > nVidia Corporation MCP67 Ethernet (rev a2)
> > Davicom Semiconductor, Inc. 21x4x DEC-Tulip compatible 10/100 Ethernet (rev
> > 31)
> >
> > Bridge works if nvidia is the LAN side and Davicom on WAN side, but no way
> > to get bridge working if nvidia is on LAN and Davicom on WAN -
> 
> 
> I have no clue what you're talking about.  The bridge logic treats all ports
> exactly the same, except when it comes to spanning tree choosing one to shut
> down when it detects a link.  Beyond that, your "working" and "not working"
> don't seem to be different.
> 
> Are you sure you are using bridging, and not routing or NAT?
> 
> 
> >
> >
> > Driver for Davicom is dmfe; with driver Tulip interface isn't even added to
> > bridge
> >
> > Paolo
> >

Maybe one of the drivers (or providers) doesn't do promiscious mode and
expects only a particular MAC address.

-- 
