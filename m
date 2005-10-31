From: "Josh Burke" <kernelbridgeissue@iokui.com>
Message-ID: <W7542030769198281130775534@webmail4>
Date: Mon, 31 Oct 2005 16:18:54 +0000
Subject: Re: [Bridge] slow network performance when using bridged interfaces 
	in 2.6.13 compared to 2.6.12.
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

> Since you are using an e100, I would suspect the "CPU cycle saver"
> patch that was added in 2.6.13, then removed in one of the stablilty
> releases. A fixed version of the patch is in 2.6.14.  Read the
> netdev archives for more detail.

Thank you for the pointer.  That appears to have fixed the problem.

- Josh



