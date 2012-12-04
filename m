Return-Path: <sharat04@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=dCW3ZuEUQnAfW2UbSy+2eagvajX1ghhrXZdnNVlWshQ=;
	b=uPcl8xSt2R5xAWMYWMVHlkL1KKo8k7Ga/EpGNtNrSO9ERYJ6dN7usgGVCiPcluBzUv
	BHhYho1wlfUA9+WJs9bzshQyBwoI6vx9x6iJnx703OHUaVVM5xZ5aDGr6tDinCeXZtT3
	kzYyLj7wb4Gt6qpZkZ8FdCmnr2ToWjOP3V5nzzC5Gb1L2I7OJwqiCh64NMHC1J02M5ut
	vgim8VZGe6/PfDqxMLhMFSavQ+839s+LhnmaymhZ7BqfllgnlQCBsb81dlpxgY0kFq74
	2LrhHCF8EKUPULt0HNjkVK6SPyUjcF5sDAL0FLDvBLIMIFYkyr+CzHFBxgz0YvWjNsZA
	9Z2g==
MIME-Version: 1.0
Date: Mon, 3 Dec 2012 20:15:24 -0700
Message-ID: <CAJzFV35xUL6xgxc9pssvcGVhfVC+qOPnpMpX635Qk9eR1DkU6Q@mail.gmail.com>
From: sharat chandra <sharat04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] Help IPV6 neighbor cache & Bridging (RTM_NEWNEIGH)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi All,

I have a simple linux based Access point /Wireless router  setup with
dual SSID's. Let me explain the setup. I have a bridge interface used
only for V6 traffic

brctl addbr bridge0
brctl addif bridge0 wlan0
brctl addif bridge wlan1

The bridge is setup and works fine and cilents are able to associate
with these SSID's and data traffic works.

My question is the neighbor cache information is always associated
with bridge0 i.e the neighbor cache looks like this

<V6 addr> dev bridge0 lladdr <mac addr> REACHABLE.

The clients mac address is typically  associated with either wlan0 or
wlan1 if there was no bridge, but with bridge enabled, its always
associated with bridge interface.  Is there a way to get the actual
interface name for a clients mac address that is either wlan0 or wlan1
from the neighbor cache or from netlink events? Is there any other way
to get this information?

Any information would be really helpful.

Thank You,
Sharat
