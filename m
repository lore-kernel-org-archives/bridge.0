Date: Fri, 8 Aug 2003 10:14:12 +1000
From: Cameron Simpson <cs@zip.com.au>
Message-id: <20030808001412.GB1269@cskk.homeip.net>
Reply-to: cs@zip.com.au
References: <AD59566A9D83864F871AE2E525030640050722@aimail.aiinet.priv>
Mime-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <AD59566A9D83864F871AE2E525030640050722@aimail.aiinet.priv>
Subject: [Bridge] Re: ebtables target to disable an interface
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
To: bridge@osdl.org

On 16:44 07 Aug 2003, Eble, Dan <DanE@aiinet.com> wrote:
| I would like to set up an ACL for an ethernet port using ebtables rules, and
| if a security violation occurs, to physically disable the port (i.e.
| whatever "ifconfig down" does).  I did not see such a feature in the
| ebtables man page.  Does this exist anywhere, or do I have to create a new
| extension for it?

You could log the event, and monitor the log with a
	tail -f logfile | ...
to turn it off. No extension needed.
-- 
Cameron Simpson <cs@zip.com.au> DoD#743
http://www.cskk.ezoshosting.com/cs/

Loud Pipes make noise.
Skill and experience save lives.
        - Ed Morandi, edm@cbnewsj.att.com, DoD#0733
