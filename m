Message-ID: <4242B362.1070309@asenovgrad.net>
Date: Thu, 24 Mar 2005 14:32:34 +0200
From: jiv <jiv@asenovgrad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Transparent shaper with 2.6 kernel
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all!

I'm trying to make a transparent shaper with kernel 2.6.11
I have done this and used it many times on 2.4.25 kernel and 
ebtables-brnf-5_vs_2.4.25.diff
On 2.4.25 I have been using U32 classifiers and HTB.
On 2.6.11 even with :

newserver ~ # zcat /proc/config.gz | grep -i BRIDGE_NETFILTER
CONFIG_BRIDGE_NETFILTER=y

newserver ~ # ls /proc/sys/net/bridge/
bridge-nf-call-arptables  bridge-nf-call-ip6tables  
bridge-nf-call-iptables  bridge-nf-filter-vlan-tagged
newserver ~ # cat /proc/sys/net/bridge/*
1
1
1
1

I'm still not succeeding ti shape the traffic on the bridge interface

Any ideas please???
