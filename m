Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
From: Diego Liziero <liziero.diego@unimore.it>
In-Reply-To: <20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084472140.3354.9.camel@igno>
Mime-Version: 1.0
Date: Thu, 13 May 2004 20:15:40 +0200
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Sorry, I've been too quick in writing without realizing
that the patch had been already posted to this mailing list.

This patch solved everything.

Thank you.

BTW, there is another issue that may be related to the bridge
that is being discussed on bluez-devel mailing list:

http://thread.gmane.org/gmane.linux.bluez.devel/2160

Regards,

Diego

On Thu, 2004-05-13 at 19:28, Stephen Hemminger wrote:
> 2.6.6 got too picky about multiple interfaces with the same
> address. This patch has been already integrated for later releases.


