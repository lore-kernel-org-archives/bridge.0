Date: Mon, 12 Jan 2004 08:27:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge Netfilter question
Message-Id: <20040112082701.53651d08.shemminger@osdl.org>
In-Reply-To: <1073921027.25629.21.camel@honeycomb>
References: <1073921027.25629.21.camel@honeycomb>
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
To: raj@roinet.com
Cc: bridge@osdl.org

You shouldn't have to change an existing line of code to do what you want!
Make your new filter a module.

In the routine called by module_init(), add a call to ebt_register_table()
You need to setup an struct ebt_table to describe your new filter.

Look at source for exist ebtable modules to see how to do it.

Of course, make sure and unregister and cleanup on module removal.
