Message-ID: <42048053.6080309@web.de>
Date: Sat, 05 Feb 2005 09:14:11 +0100
From: Michael Renzmann <mrenzmann@web.de>
MIME-Version: 1.0
Subject: Re: [Bridge] Wireless bridge
References: <33113.24.85.247.221.1107543328.squirrel@heteromail.com>
In-Reply-To: <33113.24.85.247.221.1107543328.squirrel@heteromail.com>
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
To: Jordan Eunson <maillist@heteromail.com>
Cc: bridge@osdl.org

Hi.

Jordan Eunson wrote:
> running madwifi on the other. I want the linux box to be a bridge between
> the hard wired clients connect to the linux router and wireless linksys
> box on the other side of the office. 

You need to use the WDS mode which allows to bridge two networks over a 
wireless connection. This mode isn't supported yet by madwifi, don't 
know about the Linksys. In other words: your constellation currently 
doesn't allow bridging.

In case you only want to make use of IP protocols you could make use of 
proxy arp. http://freshmeat.net/projects/parprouted/ might be of help 
for such a setup.

Bye, Mike
