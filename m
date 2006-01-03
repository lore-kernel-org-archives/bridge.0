Date: Tue, 3 Jan 2006 09:51:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] mac address
Message-ID: <20060103095153.0f9a63ba@dxpl.pdx.osdl.net>
In-Reply-To: <20051230182527.14448.qmail@web33501.mail.mud.yahoo.com>
References: <20051230182527.14448.qmail@web33501.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeff Sadowski <jeff_sadowski@yahoo.com>
Cc: bridge@lists.osdl.org

On Fri, 30 Dec 2005 10:25:27 -0800 (PST)
Jeff Sadowski <jeff_sadowski@yahoo.com> wrote:

> is there a way to set the mac address of a bridge?
Not till 2.6.16.  In 2.6.16 mac address of bridge can be set with
ifconfig (or other tools) to any of the enslaved device address

> How is the mac address determined on a bridge?
The minimum of all the mac addresses of all the enslaved devices.
This is part of the STP code. Related to assigning bridge id.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
