Message-ID: <AD59566A9D83864F871AE2E525030640050722@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Date: Thu, 7 Aug 2003 16:44:32 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] ebtables target to disable an interface
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: "'bridge@osdl.org'" <bridge@osdl.org>

I would like to set up an ACL for an ethernet port using ebtables rules, and
if a security violation occurs, to physically disable the port (i.e.
whatever "ifconfig down" does).  I did not see such a feature in the
ebtables man page.  Does this exist anywhere, or do I have to create a new
extension for it?

-- 
Dan Eble <dane@aiinet.com>  _____  .
                           |  _  |/|
Applied Innovation Inc.    | |_| | |            "All Protocols MUST be odd"
http://www.aiinet.com/     |__/|_|_|              -- RFC 1661 (PPP)
