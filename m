Subject: Re: [Bridge] Trouble with bridged interfaces
From: Brad Dameron <brad.dameron@clearwire.com>
In-Reply-To: <20070615092100.5df0c045@localhost>
References: <63CB92BFF23FC54A8CF2F4A67654B24601F5D163@i-worx-srv-02.i-worx.ca>
	<20070615092100.5df0c045@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Jun 2007 15:39:40 -0700
Message-Id: <1181947180.5894.6.camel@linux-2n2q.site>
Mime-Version: 1.0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org

On Fri, 2007-06-15 at 09:21 -0700, Stephen Hemminger wrote:
> On Wed, 13 Jun 2007 18:28:07 -0700
> "Roman Lisagor" <RLisagor@wurldtech.com> wrote:
> 
> > Hi,
> > 
> > We need to bridge several interfaces together, but still retain the
> > ability to communicate through the individual interfaces. So for
> > example, we have eth0 and eth1 bridged and we bind IP addresses to both
> > of them, in order to inject packets into communication between two
> > devices connected to our interfaces.
> > 
> 
> 
> Addresses in Linux aren't assigned to interfaces.
> Look up the regular questions that come up about Linux responding
> to ARP on the wrong interface.
> 
> > It seems that several problems arise intermittently:
> > 
> > 1. When sending ping requests, replies sometimes come in on eth0/1, but
> > sometimes on br0. We can work around this, but it would be great to get
> > some idea of why and when this happens (and possibly whether we can
> > prevent it from occurring);
> > 
> > 2. Occasionally, ARP requests sent by external devices for the IPs of
> > eth0/1 are ignored.
> > 
> > We are running Fedora Core 6 (2.6.13-15-smp).
> > Any ideas?
> >  
> > Thanks in advance for your help.
> > 
> > Roman


You should look at using ebtables to control the ARP. This is how we
handle it.


Brad Dameron
Systems Engineer
Clearw're

