Date: Mon, 29 Jan 2007 14:46:46 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070129144646.52279182@freekitty>
In-Reply-To: <EBDEAF27DD61EA40A5DF1D15EAD9735389515E@krkexchange4.corp.clearwire.com>
References: <1169857805.28708.1.camel@linux-2n2q.site>
	<20070126210947.75c55177@localhost.localdomain>
	<EBDEAF27DD61EA40A5DF1D15EAD9735389515E@krkexchange4.corp.clearwire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Clear a mac from table?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Brad Dameron <Brad.Dameron@clearwire.com>
Cc: bridge@lists.osdl.org

On Sat, 27 Jan 2007 16:46:22 -0800
"Brad Dameron" <Brad.Dameron@clearwire.com> wrote:

> This is true. But here is a scenario we are seeing. Here is our setup first.
>  
> Customer is on Vlan4 which is bridged to VLAN10. Both vlan's are on the same switch. If data is streaming in on vlan10 to the vlan4 bridge, then we switch the customer to vlan10, the streaming data will continue on to the bridge server and the customer will not be able to transfer data until that stream dies or if the timer just happens to be expiring for that MAC. So we need to clear the mac. I did a brctl setageing 3 to set the timer lower. But what effect could this have when I have some 50k to 100k mac's known by the bridging server?
>  
> Thanks,
> Brad Dameron
> Clearw're
> Network Engineer TierII

If you remove vlan from bridge (or force carrier down), then
the entries are purged

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
