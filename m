Message-ID: <449A5C49.1030400@kingsley.co.za>
Date: Thu, 22 Jun 2006 11:00:57 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Newbie at work - need some advise/guidence please.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Here are the rules, policy is set to DROP on all accounts.

ebtables -t filter -P INPUT DROP
ebtables -t filter -A INPUT -p IPv4 -j ACCEPT
ebtables -t filter -A INPUT -p ARP -j ACCEPT
ebtables -t filter -A INPUT -d BGA -j ACCEPT
ebtables -t filter -P FORWARD DROP
ebtables -t filter -A FORWARD -p IPv4 -j ACCEPT
ebtables -t filter -A FORWARD -p ARP -j ACCEPT
ebtables -t filter -A FORWARD -d BGA -j ACCEPT
ebtables -t filter -P OUTPUT DROP
ebtables -t filter -A OUTPUT -p IPv4 -j ACCEPT
ebtables -t filter -A OUTPUT -p ARP -j ACCEPT
ebtables -t filter -A OUTPUT -d BGA -j ACCEPT

Hopefully someone will find this info also usefull.

-- 
Kind Regards
Etienne



