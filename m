DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	b=Nm0b7QGSkhZrxRX1S0VS1IL0I/BJXysZU27BLx1JfvadfDnB3A6H5o0oKweMtMmWeVufkxYgCCjBy5paaQzzQ/nmiA0gyElHxnZ1e8975+9PSkKH2OIl/XDBK5s0VCygy6bhe/N23dejtISLKSoFAT7w8KbWIX4CeuUax+SzAxs=
Message-ID: <bcba51a0706131332p4aef4a38sdc9cafd726528cd9@mail.gmail.com>
Date: Wed, 13 Jun 2007 16:32:09 -0400
From: "Dimitry Golubovsky" <golubovsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Is it possible to put an aliased ethernet card on a bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

Suppose we have two aliases of the same ethernet card:

ifconfig eth0 192.168.0.1
ifconfig eth0:1 192.168.1.1

Is it possible to add eth0:1 to a bridge, not adding its "physical parent" eth0?

Sorry if this was answered before.

Thanks.

-- 
Dimitry Golubovsky

Anywhere on the Web
