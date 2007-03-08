Message-ID: <45EFE02A.9010306@cambridgebroadband.com>
Date: Thu, 08 Mar 2007 10:06:34 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <DE026503646E7F40AF97BAB98334333B018A6F21@uss-republic.finepoint.com>
In-Reply-To: <DE026503646E7F40AF97BAB98334333B018A6F21@uss-republic.finepoint.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Linux-ATM-General] BR2684-rt and brctl
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <hwang@finepoint.com>
Cc: linux-atm-general@lists.sourceforge.net, bridge@lists.osdl.org

Hai Wang wrote:
> Hello,
> 
>  
> 
>         I am wondering if any of you knows how to add BR2684-rt nas 
> interfaces into a Ethernet bridge, I know that brctl will work with 
> BR2684-br, but not for BR2684-rt.
> 
>  
>

Hi Hai,

Looking at the RFC, it doesn't appear that the MAC address is even
present in routed RFC2684 PDUs.  It would seem to me that this makes
it impossible to add routed interfaces to a bridge.

See below,

Alex

---snip---
5.1.  LLC Encapsulation for Routed Protocols

    In LLC Encapsulation, the protocol type of routed PDUs MUST be
    identified by prefixing an IEEE 802.2 LLC header to each PDU.  In
    some cases, the LLC header MUST be followed by an IEEE 802.1a
    SubNetwork Attachment Point (SNAP) header.  In LLC Type 1 operation,
    the LLC header MUST consist of three one octet fields:

                     +------+------+------+
                     | DSAP | SSAP | Ctrl |
                     +------+------+------+

    In LLC Encapsulation for routed protocols, the Control field MUST be
    set to 0x03, specifying a Unnumbered Information (UI) Command PDU.

    The LLC header value 0xFE-FE-03 MUST be used to identify a routed PDU
    in the ISO NLPID format (see [6] and Appendix B). For NLPID-formatted
    routed PDUs,  the content of the AAL5 CPCS-PDU Payload field MUST be
    as follows:

             Payload Format for Routed NLPID-formatted PDUs
                  +-------------------------------+
                  |       LLC  0xFE-FE-03         |
                  +-------------------------------+
                  |     NLPID (1 octet)           |
                  +-------------------------------+
                  |             .                 |
                  |            PDU                |
                  |     (up to 2^16 - 4 octets)   |
                  |             .                 |
                  +-------------------------------+
--/snip---





> Many thanks!
> 
>  
> 
>  
> 
> Hai
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linux-atm-general mailing list
> Linux-atm-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-atm-general

