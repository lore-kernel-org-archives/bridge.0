Message-ID: <41B03950.5000106@web.de>
Date: Fri, 03 Dec 2004 11:00:48 +0100
From: Michael Renzmann <mrenzmann@web.de>
MIME-Version: 1.0
Subject: Re: [Bridge] bridge in 'hub' mode possible?
References: <87d5xw4uui.fsf@aka.i.naked.iki.fi>	<20041129102432.24888dad@zqx3.pdx.osdl.net>	<87ekic1p6w.fsf@aka.i.naked.iki.fi>
	<20041202112002.444fdff0@dxpl.pdx.osdl.net>
In-Reply-To: <20041202112002.444fdff0@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mrenzmann@web.de
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi.

Stephen Hemminger wrote:
> Have you tried "brctl setageingtime br0 0" to turn off 
> forwarding table?

I wonder if it would be worth to introduce some kind of "monitor 
interface" for a brigde (as can be found on switches, don't know if 
"monitor port" would be the correct term for it).

The bridge could work as usual, while this virtual interface sees every 
packet that traverses the bridge. tcpdump & co could be used on this 
interface when needed. As an addition it should be possible to 
enable/disable this interface using a new brctl command (something like 
"brctl br0 monitor on|off").

Comments? If there's interest in such a function I possibly could spend 
some time on it after christmas.

Bye, Mike
