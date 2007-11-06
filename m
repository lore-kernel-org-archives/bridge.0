Subject: RE: [Bridge] Lowering CPU utilisation
From: Brad Dameron <brad.dameron@clearwire.com>
In-Reply-To: <1194387232.7283.5.camel@linux-2n2q.site>
References: <96CF49BD8B56384395D698BA99007FA32D23@exchange.pacwire.local>
	<1194387232.7283.5.camel@linux-2n2q.site>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Nov 2007 14:19:51 -0800
Message-Id: <1194387591.7458.0.camel@linux-2n2q.site>
Mime-Version: 1.0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Tue, 2007-11-06 at 14:13 -0800, Brad Dameron wrote:
> On Wed, 2007-11-07 at 08:51 +1100, Leigh Sharpe wrote:
> > I'm using e1000 cards.
> > According to oprofile, around 50% of the time is spent in the e1000
> > driver. 
> > Given that my load average is still under 0.5, I suspect I've got
> > plenty of room for the driver to handle more traffic before I need to
> > worry too much.
> >  
> > 
> > 
> > ______________________________________________________________________
> > From: Vaidas M [mailto:admin@vdx.lt] 
> > Sent: Tuesday, 6 November 2007 9:32 PM
> > To: Leigh Sharpe
> > Subject: RE: [Bridge] Lowering CPU utilisation
> > 
> > 
> > 
> > What kind of NIC you are using?
> > 
> > I suggest you to use cards with NAPI featured in driver.
> > 
> >  
> > 
> >                         _      _     _    _   _  _ _ __ ___ ____ _____
> > 
> >                                                             Vaidas M. 
> > 
> > 
> >  
> > 
> > From: bridge-bounces@lists.linux-foundation.org
> > [mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Leigh
> > Sharpe
> > Sent: Thursday, November 01, 2007 12:00 AM
> > To: bridge@lists.linux-foundation.org
> > Subject: [Bridge] Lowering CPU utilisation
> > 
> > 
> >  
> > 
> > Hi All, 
> > 
> > 
> >  I have a box with 12 bridges on it, each of which has 2 ports.
> > 
> > 
> > When the traffic level on the box reaches around 15-20Mbps on each
> > bridge, my CPU utilisation gets to about 90-95%.
> > 
> > 
> > I would like to avoid working the CPU that hard. Is there anything
> > which can be done to get the CPU utlilisation down a bit? I have plans
> > for an even bigger bridge, but these results indicate that it may not
> > scale quite that well.
> > 
> > 
> >  
> > 
> > 
> > Regards,
> >              Leigh
> > 
> 
> 
> I assume you are using Linux. Try setting these in your /etc/sysctl.conf
> file.
> 
> # increase TCP max buffer size
> net.core.rmem_max = 8388608
> net.core.wmem_max = 8388608
> # increase Linux autotuning TCP buffer limits
> # min, default, and max number of bytes to use
> net.ipv4.tcp_mem = 8388608 8388608 8388608
> net.ipv4.tcp_rmem = 4096 1048576 8388608
> net.ipv4.tcp_wmem = 4096 65535 8388608
> net.core.optmem_max = 40960
> 
> 
> Then load them with sysctl -p command.
> 
> Hope this helps. 

Oops. Too many lists. Of course your using Linux.


Brad Dameron
Senior Systems Engineer
Clearw're


