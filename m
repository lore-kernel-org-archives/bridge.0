Date: Wed, 19 May 2004 09:10:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] BPDU generation problem
Message-Id: <20040519091002.004f7f46@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0ab408a.046@EMAIL>
References: <s0ab408a.046@EMAIL>
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
To: Kishore A K <kishoreak@myw.ltindia.com>
Cc: bridge@lists.osdl.org

On Wed, 19 May 2004 11:09:58 +0530
"Kishore A K" <kishoreak@myw.ltindia.com> wrote:

> Hi Stephan,
> 
> But is it not a serious bug cause it is going to the affect the topology of the 
> entire network on to which the bridge is connected..
> 
> Regards,
> Kishore

Well if the network has other bridges, then you really need to run STP anyway.
Otherwise, the bridges won't know about each other at all and the potential exists
for all sorts of nasty things like loops and dead connections.
