Date: Thu, 22 Feb 2007 10:17:01 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070222101701.4f9255fe@freekitty>
In-Reply-To: <45DD680A.9060309@elitecore.com>
References: <45DD680A.9060309@elitecore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Outgoing Pkt interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Darshak <darshak@elitecore.com>
Cc: bridge@lists.osdl.org

On Thu, 22 Feb 2007 15:23:14 +0530
Darshak <darshak@elitecore.com> wrote:

> Hi,
>  I want to change outgoing packets interface after dnating . How can I 
> do that ?
> 
> 
> Thanxs
> Darshak
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 

That is really a netfilter question. You can use ebtables hook onto
the post routing chain.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
