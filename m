Date: Wed, 12 Jan 2005 10:21:03 +0100
From: Gergely Madarasz <gorgo@broadband.hu>
Subject: Re: [Bridge] Re: tg3 bridge problems
Message-ID: <20050112092103.GH10074@thunderchild.debian.net>
References: <20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<1105416406.4923.8.camel@localhost.localdomain>
	<20050111085216.GA10074@thunderchild.debian.net>
	<41E3C868.5040605@redhat.com>
	<20050111125831.GD10074@thunderchild.debian.net>
	<41E3D0AB.6060608@redhat.com>
	<20050111140704.GE10074@thunderchild.debian.net>
	<27034.63.87.1.243.1105474752.squirrel@randomparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27034.63.87.1.243.1105474752.squirrel@randomparity.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dave@randomparity.com
Cc: linux-net@vger.kernel.org, nhorman@redhat.com, bridge@lists.osdl.org

On Tue, Jan 11, 2005 at 12:19:12PM -0800, dave@randomparity.com wrote:
> Greg,
> 
> My understanding was that the x346 provides remote management support
> through an integrated IPMI system management processor (according to the
> x346 data sheet).  I also know that the Broadcom controllers provide IPMI
> management support through firmware which runs on the controller.  Perhaps
> the problem is that the IPMI firmware is resetting promiscuous mode on the
> MAC underneath the driver after the hardware reset occurs.

Sounds possible, but why would it do that?

> Does the x346 provide any mechanisms to disable the IPMI system management
> processor (perhaps a BIOS setup option)?  Does the problem go away when
> you do so?

No, unfortunatelly I didn't find any way to turn it off. 

Greg
