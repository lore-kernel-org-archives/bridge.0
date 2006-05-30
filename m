Date: Tue, 30 May 2006 16:21:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060530162106.30702d1b@dxpl.pdx.osdl.net>
In-Reply-To: <447CBD31.2090802@arcoscom.com>
References: <447CBD31.2090802@arcoscom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] setportprio problem with bridge-utils 1.0.6
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Tue, 30 May 2006 23:46:25 +0200
Samuel Díaz García <samueldg@arcoscom.com> wrote:

> I'm having a problem with brctl when I want to set prio in a bridge port.
> 
> When I execute:
> 
> brctl setbridgeprio br0 eth1 10
> 
> (for example)

All it ends up doing is writing a 10 to /sys/class/net/br0/bridge/port_cost

The problem (or feature) is that the bridge will autodetect
the port cost based on the link speed when the bridge or port
is started up. So you need to change the port cost after the
bridge is already running to cause any effect.

> 
> I can see how that value (10) is asigned to the port cost.
> 
> Is this a known issue with this version?
> 
> I detected this with FC5 bridge-utils package and with dd-wrt bridge-utils.
> 
> Any help about this?
> 
