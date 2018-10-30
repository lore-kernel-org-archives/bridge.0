Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : mime-version : content-type; s=corp-2018-07-02;
	bh=dD0yPmRhok8e0J2c8KMx/MVQyZPCrbH9e0tn9dfy+wk=;
	b=OzoHBrhgPLfiOuD2UxIQSjQw4WssXlskip1HoY3T9+1egmFqDFeR3uFdszMgmWMxexcV
	n9y5Dl22Bd+Py9/DRTSmntml5Cxx1C5Lo4IBgmJM/ypZZGXvSgKtjg427Wenbvw4gi+D
	funef+r9ckO/kiV7Sg0feftKWPczqxfTBBpKg5Pz7XdHF+kBmigvBvsA8ttYi1aqEj9c
	L8N3Hwz77Bd7vrlBSVRVNA5YhFBNETTTzjkvLfzKia5ShBkHamRn+xrFM9nP+tgD+evO
	0884bYa4pLYZrWEIe1GY/IeOF8sJERTAMpbgW6rf1+adxsajsW8jOeZUkgXdhEQgRp12
	Tg== 
Date: Tue, 30 Oct 2018 12:18:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20181030091828.4i5x354yigemnfmo@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [bug report] net: bridge: add support for raw sysfs port
	options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: bridge@lists.linux-foundation.org

Hello Nikolay Aleksandrov,

This is a semi-automatic email about new static checker warnings.

The patch a5f3ea54f3cc: "net: bridge: add support for raw sysfs port 
options" from Jul 23, 2018, leads to the following Smatch complaint:

    net/bridge/br_sysfs_if.c:323 brport_store()
     warn: variable dereferenced before check 'p->dev' (see line 317)

net/bridge/br_sysfs_if.c
   316	
   317		if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
                                        ^^^^^^
Dereferenced here.

   318			return -EPERM;
   319	
   320		if (!rtnl_trylock())
   321			return restart_syscall();
   322	
   323		if (!p->dev || !p->br)
                    ^^^^^^^
Hopefully this can't happen?

   324			goto out_unlock;
   325	

regards,
dan carpenter
