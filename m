Date: Thu, 2 Dec 2004 11:09:17 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge problem
Message-Id: <20041202110917.1dfcc472@dxpl.pdx.osdl.net>
In-Reply-To: <20041115185806.6aece278.jvalencia@log01.org>
References: <20041115185806.6aece278.jvalencia@log01.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Mon, 15 Nov 2004 18:58:06 +0000
Javier Valencia <jvalencia@log01.org> wrote:

> I'm getting problems with my bridge (linux 2.6.9, eth0 = via-rhine, eth1 = 8139too).
> The problem is that eth1 links up and down intermitently (between 1-2 minutes).
> 
> What can i do?
> 
> Thanks
> 

You could turn on debugging in the 8139too driver and add additional
instrumentation to see why it thinks it loses carrier. Also, do the
obvious stuff like check the cable and what is connected to (router, hub, switch, 
DSL modem, ...). Maybe there is a duplex or speed mismatch?
