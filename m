From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] [RELEASE] ebtables-brnf-3-vs-2.4.22 and ebtables-2-0-6
Date: Mon, 3 Nov 2003 22:54:43 +0100
References: <20031103152817.1022.qmail@web13910.mail.yahoo.com>
In-Reply-To: <20031103152817.1022.qmail@web13910.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311032254.43243.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Scott MacKay <scottmackay@yahoo.com>, ebtables-user <ebtables-user@lists.sourceforge.net>, bridge <bridge@osdl.org>

On Monday 03 November 2003 16:28, Scott MacKay wrote:
> Is there a way to indicate the changes performed for
> the userspace mangle bug?  Currently, I am a bit tied
> to 2.4.20 until a new round of kernel upgrades are
> allowed....

Dave's fix for 2.6 looks like this:

--- net/core/skbuff.c.~1~       Tue Oct 28 06:54:49 2003
+++ net/core/skbuff.c   Tue Oct 28 06:58:38 2003
@@ -591,8 +591,8 @@
        /* Set the tail pointer and length */
        skb_put(n, skb->len);
 
-       /* Copy the data only. */
-       if (skb_copy_bits(skb, 0, n->data, skb->len))
+       /* Copy the linear data and header. */
+       if (skb_copy_bits(skb, -newheadroom, n->head, newheadroom + skb->len))
                BUG();
 
        copy_skb_header(n, skb);

