Date: Thu, 24 Jun 2004 10:38:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Interface or Linux crashes when put in bridge mode
Message-Id: <20040624103854.711254aa@dell_ss3.pdx.osdl.net>
In-Reply-To: <FD52892BD296D71183B400065BFCB6900BAE5436@il02exm12>
References: <FD52892BD296D71183B400065BFCB6900BAE5436@il02exm12>
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
To: Lewis Adam-CAL022 <Adam.Lewis@motorola.com>
Cc: bridge@osdl.org

 
> So I am hoping somebody can shed some light.  I am not an expert on the Linux bridge code, but I would assume it simply takes the data passed to one interface and gives it to the next; so my WLAN driver should not know or care if the data is coming from a local ping or a ping from another box, cause it should receive the same skb, right?  I am at a total loss to explain it at this time.
> 

Sorry, won't fix your driver for you... It's open source walkthrough the code.
You might find that your driver doesn't like it when it's transmit routine
is called from softirq? or maybe it doesn't like spoofing the source Ethernet
address. Use printk's or kgdb; it can't be that hard to find.
